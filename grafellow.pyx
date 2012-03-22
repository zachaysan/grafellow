from pprint import pprint
import ujson

class Grafellow(object):
    def __init__(self, filename=None, testing=None):
        self.testing = testing
        if filename:
            self.load_graph_from_file(filename)
        self.make_internal_structures()

    def add_node(self, node, node_type, attr=None):
        internal_node_id = self.get_node_id(node, node_type)
        if not internal_node_id:
            internal_node_id = self.assign_internal_node_id(node, node_type)
        self.nodes[internal_node_id] = attr

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

    def get_internal_node_ids(self, node, node_type):
        pass

    def get_internal_node_ids_with_nbunch(self, nbunch):
        pass
    
    def assign_internal_node_id(self, node, node_type):
        self.last_internal_node_id += 1
        self.internal_node_ids[(node, node_type)] = self.last_internal_node_id
        return self.last_internal_node_id
    
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
        self.last_internal_node_id = 0
        self.nodes = {}
