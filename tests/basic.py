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
        self.assertTrue(not g.add_node('zach', 'person'))
        
    def test_add_node_with_data(self):
        g = Grafellow(testing=True)
        attrs = {'languages': ['python', 'ruby', 'others']}
        self.assertTrue(not g.add_node('zach', 'person', attrs))
        self.assertTrue(g.get_node('zach','person'))
