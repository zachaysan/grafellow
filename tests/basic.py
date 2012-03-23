import unittest

from grafellow import Grafellow

class BasicTest(unittest.TestCase):
    def setUp(self):
        pass

    def test_blow_up(self):
        """ it does not blow up on init """
        g = Grafellow()
        self.assertTrue(g)
        
    def test_add_node(self):
        g = Grafellow()
        node_id_should_be = 1
        self.assertTrue(g.add_node('zach', 'person') == node_id_should_be)
        
    def test_add_node_with_data(self):
        g = Grafellow()
        attrs = {'languages': ['python', 'ruby', 'others']}
        self.assertTrue(g.add_node('zach', 'person', attrs))
        self.assertTrue(g.get_node('zach','person'))
        
    def test_add_non_directed_edge(self):
        g = Grafellow()
        g.add_non_directed_edge('zach', 'person', 'laura', 'person', edge_type='friends')
        self.assertTrue(g.get_node('zach','person') == {})
        self.assertTrue(g.get_node('laura','person') == {})
        self.assertTrue('laura' in g.node_edges('zach', 'person', other_node_type='person'))

    def test_add_non_directed_edge_with_multiple_edges_and_tuples(self):
        g = Grafellow()
        g.add_non_directed_edge('zach', 'person', 'laura', 'person',
                                edge_type='friends')
        g.add_non_directed_edge('zach', 'person', 'jaco', 'robot',
                                edge_type='friends')
        self.assertTrue(('jaco','robot') in g.node_edges('zach', 'person'))
        self.assertTrue(('laura','person') in g.node_edges('zach', 'person'))

    def test_retrieving_edge_type(self):
        pass
    
    def test_retrieving_all_edges(self):
        pass

    def test_retrieving_all_edges_with_attr_data_returned(self):
        pass
    
    def test_adding_directed_edges(self):
        pass

    def test_retrieving_all_directed_edges_with_attr_data_returned(self):
        pass
    
    def test_retrieving_a_collapsed_list_of_nodes_that_meet_node_type(self):
        pass

    def test_retrieving_a_collapsed_list_of_nodes_that_meet_edge_type(self):
        pass

    def test_retrieving_a_collapsed_list_of_nodes_that_meet_both(self):
        """ since node_type and edge_type may both be important """
        pass

    def test_retrieving_all_incoming_edges(self):
        pass
