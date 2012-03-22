from pprint import pprint
import ujson

class Grafellow(object):
    def __init__(self, filename=None):
        if filename:
            self.load_graph_from_file(filename)

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
        
