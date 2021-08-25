#!/usr/bin/env python3

import yaml
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

CONFIG = 'myservice.yaml'
BASE_PATH = os.path.dirname(os.path.abspath(__file__))
CONFIG_PATH = "{}/{}".format(BASE_PATH, CONFIG)

def load_config(path):
    with open(path) as f:
        global_conf = yaml.load(f)
    return global_conf

CONFIG = load_config(CONFIG_PATH)
PORT = CONFIG['port']

class TestHttpHandler(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        message = "Hello World!"
        message_byte = message.encode()
        self._set_headers()
        self.wfile.write(message_byte)

def run_server(port):
    server_class = HTTPServer
    handler_class = TestHttpHandler
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print('Starting http server...')
    httpd.serve_forever()

if __name__ == "__main__":
    run_server(PORT)
