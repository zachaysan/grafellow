import unittest

from grafellow import Grafellow

class BasicTest(unittest.TestCase):
    def setUp(self):
        pass

    def test_blow_up(self):
        """ it does not blow up on init """
        g = Grafellow()
        self.assertTrue(g)
