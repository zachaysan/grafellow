from pprint import pprint
import collections
import ujson

class Grafellow(object):
    def __init__(self, filename=None, testing=None):
        self.testing = testing
        if filename:
            self.load_graph_from_file(filename)
        self.make_internal_structures()

    """ This section deals with adding nodes to the graph """

    def add_node(self, node, node_type, attr=None):
        if not attr:
            attr = {}
        internal_node_id = self.get_node_id(node, node_type)
        if not internal_node_id:
            internal_node_id = self.assign_internal_node_id(node, node_type)
        self.nodes[internal_node_id] = attr
        return internal_node_id
    
    def add_node_if_not_exists(self, node, node_type, attr=None):
        internal_node_id = self.get_node_id(node, node_type)
        if not internal_node_id:
            internal_node_id = self.add_node(node, node_type, attr)
        return internal_node_id

    def get_node(self, node, node_type):
        internal_node_id = self.get_node_id(node, node_type)
        return self.nodes[internal_node_id]

    def get_node_id(self, node, node_type):
        """ Note: this area should be replaced at some point with 
        a real data store since by doing this we are now storing the nodes
        in memory multiple times which is really stupid.
        
        Since the hardest part with graphs is to:
         - Fit all the data in RAM
         - traverse connections quickly (NP Hard problems abound)
         
         The current solution only solves the second part, rather than both,
         which, ideally, it would do.
        """
        return self.internal_node_ids.get((node, node_type), 0)

    def get_internal_node_ids_with_nbunch(self, nbunch):
        pass
    
    def assign_internal_node_id(self, node, node_type):
        self.last_internal_node_id += 1
        self.internal_node_ids[(node, node_type)] = self.last_internal_node_id
        self.external_node_type_tuples[self.last_internal_node_id] = (node, node_type)
        return self.last_internal_node_id
    
    """ This section deals with adding edges to the graph """
    
    def add_non_directed_edge(self, node, node_type, node2, node2_type, edge_type, attrs = None):
        if not attrs:
            attrs = {}
        node_internal_id = self.add_node_if_not_exists(node, node_type)
        node2_internal_id = self.add_node_if_not_exists(node2, node2_type)
        if node_internal_id not in self.non_directed_adj:
            self.non_directed_adj[node_internal_id] = {}
        self.non_directed_adj[node_internal_id][node2_internal_id] = (edge_type, attrs)
        if node2_internal_id not in self.non_directed_adj:
            self.non_directed_adj[node2_internal_id] = {}
        self.non_directed_adj[node2_internal_id][node_internal_id] = (edge_type, attrs)
        
    def node_edges(self, *args, **kwargs):
        results = [edge for edge in self.node_edges_iter(*args, **kwargs)]
        if len(results) == 1:
            return results[0]
        else:
            return results

    def node_edges_iter(self, node, node_type, other_node_type=None, edge_types=False):
        node_id = self.get_node_id(node, node_type)
        if not other_node_type:
            for result in self.node_edge_tuples(node_id, edge_types=edge_types):
                yield result
        else:
            for result in self.node_edges_of_type(node_id, other_node_type):
                yield result

    def node_edges_of_type(self, node_id, other_node_type):
        pass_function = None
        if isinstance(other_node_type, collections.Iterable):
            pass_function = lambda t: t in other_node_type
        else:
            pass_function = lambda t: t == other_node_type
        for node_id, node_type in self.node_edge_tuples(node_id):
            if pass_function(node_type):
                yield node_id

    def node_edge_tuples(self, node_id, edge_types=False):
        for internal_adj_node_id, data in self.internal_edges(node_id):
            node_type_tuple = self.external_node_type_tuples[internal_adj_node_id]
            if edge_types:
                edge_type = data[0]
                node_id = node_type_tuple[0]
                node_type = node_type_tuple[1]
                results = (edge_type, node_id, node_type)
                yield results
            else:
                yield node_type_tuple
                
    def internal_edges(self, node_id):
        for node_internal_id in self.non_directed_adj[node_id]:
            yield (node_internal_id, self.non_directed_adj[node_id][node_internal_id])

    """ This section deals with importing data from an api or file """

    def load_graph_from_file(self, filename):
        pass
    
    def handle_json_line(self, json_line):
        obj = ujson.loads(json_line)
        action = obj['action']
        if action == 'add_node':
            pass
        elif action == 'delete_node':
            pass
        elif action == 'add_edge':
            pass
        elif action == 'delete_edge':
            pass
        
    """ This section handles setup processes """
    
    def make_internal_structures(self):
        self.node_types = {}
        self.internal_node_ids = {}
        self.external_node_type_tuples = {}
        self.last_internal_node_id = 0
        self.nodes = {}
        self.non_directed_adj = {}
