#!/usr/bin/env python

import os
from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer
import mimetypes
import posixpath
import shutil
import math
import traceback
import urllib
import sys
import cgi
import random
import string
import json
import base64
try:
    from cStringIO import StringIO
except ImportError:
    from StringIO import StringIO

USER="gustav"
PASS=USER

SV_HOST="0.0.0.0"
SV_PORT=8080
if len(sys.argv) is 2 and sys.argv[1] is not None:
    SV_PORT = int(sys.argv[1])

SITE_ROOT="http://"+SV_HOST+":"+str(SV_PORT)

BASE62_CHARSET=string.ascii_lowercase + string.digits + string.ascii_uppercase

def rand_string(n=8, charset=BASE62_CHARSET):
    res = ""
    for i in range(n):
        res += random.choice(charset)
    return res


BODY="<script class='jsbin' src='https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js'></script> <style> body { font-family: sans-serif; background-color: #eeeeee; } .file-upload { width: 600px; margin: 0 auto; padding: 20px; } .file-upload-content { display: none; text-align: center; } .file-upload-input { position: absolute; margin: 0; padding: 0; width: 100%; height: 100%; outline: none; opacity: 0; cursor: pointer; } .image-upload-wrap { margin-top: 10px; border: 4px dashed #1FB264;position: relative; height: 50px; background-color: aliceblue; } .image-dropping, .image-upload-wrap:hover { background-color: #1FB264; border: 4px dashed #ffffff; } .image-title-wrap { padding: 0 15px 15px 15px; color: #222; } .drag-text { text-align: center; } .drag-text h3 { font-weight: 100; text-transform: uppercase; color: #15824B; } </style> <script> function upload() { url = document.location.protocol + '//' + document.location.host + '/upload'; var xhr=new XMLHttpRequest(); xhr.open('post',url,true); var formData = new FormData(); var files = $('input[type=file]')[0].files; console.log(files); formData.append('file', files[0]); formData.append('rpath', document.location.pathname); xhr.send(formData); xhr.onload=function() { console.log('upload successful'); }; }; function removeUpload() { $('.file-upload-input').replaceWith($('.file-upload-input').clone()); $('.file-upload-content').hide(); $('.image-upload-wrap').show(); }; $(\"#cep\").on(\"change\", upload); $('.image-upload-wrap').bind('dragover', function () { $('.image-upload-wrap').addClass('image-dropping'); }); $('.image-upload-wrap').bind('dragleave', function () { $('.image-upload-wrap').removeClass('image-dropping'); }); </script> <form method='POST' id='contact' name='13' enctype='multipart/form-data'> <div class='file-upload'> <div class='image-upload-wrap'> <input class='file-upload-input' id='cep' type='file' onchange=\"upload(this);\" accept='*/*' /> <div class='drag-text'> <h3>Drag and drop a file</h3> </div> </div> </div> </div> </form>"


class Handler(BaseHTTPRequestHandler):

    def do_HEAD(self):
        self.send_headers()

    def do_authhead(self):
        ''' do authentication '''
        print("send header")
        self.send_response(401)
        self.send_header('WWW-Authenticate', 'Basic realm=\"Test\"')
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def send_headers(self):
        if self.headers.getheader('Authorization') is None:
            self.do_authhead()
        elif self.headers.getheader('Authorization') != 'Basic '+ base64.b64encode(USER+":"+ PASS):
            self.do_authhead()

        method = str(self.command).lower();
        if method == "post":
            return ['upload']

        npath = os.path.normpath(self.path)
        isDir = False

        reqfile = "."+npath
        reqfile = urllib.unquote(reqfile)
        x = reqfile

        print("abs path", reqfile)
        if os.path.isdir(reqfile) and os.access(reqfile, os.R_OK):
            isDir = True
            for index in "index.html", "index.htm":
                index = os.path.join(reqfile, index)
                if os.path.exists(index) and False:
                    reqfile = index
                    break
            if(reqfile):
                x = self.list_directory(reqfile)
                path_elements = [x]
        elif not os.path.isfile(reqfile) or not os.access(reqfile, os.R_OK):
            isDir = False
            self.send_error(404, "file not found")

        content=None
        # content = self.guess_type(reqfile)
        if content is None:
            content = "application/octet-stream"
        if isDir:
            content = "text/html"

        if not isDir:
            try:
                f = open(reqfile, 'rb')
                path_elements = [f]
            except IOError:
                self.send_error(404, "File not found")
                return None
            self.send_response(200)
            self.send_header("Content-type", content)
            self.end_headers()

        return path_elements


    def do_GET(self):
        elements = self.send_headers()
        if elements is None:
            return

        f = None
        if len(elements) == 1:
            f = elements[0]
        if f:
            shutil.copyfileobj(f, self.wfile)
            f.close()
        else:
            return None


    def do_POST(self):
        elements = self.send_headers()
        if elements is None or elements[0] != "upload":
            return

        form = cgi.FieldStorage(
            fp=self.rfile,
            headers=self.headers,
            environ={
                "REQUEST_METHOD": "POST",
                "CONTENT_TYPE":   self.headers['Content-Type']
            })

        _, ext = os.path.splitext(form["file"].filename)
        rpath = "." + form['rpath'].value

        fname = _ + ext
        while os.path.isfile(rpath+fname):
            fname = rand_string() + ext

        fdst = open(rpath+fname, "wb")
        shutil.copyfileobj(form["file"].file, fdst)
        fdst.close()

        self.send_response(301)
        origin=self.headers.getheader('Origin')
        self.send_header("Location", origin+rpath[1:])
        self.end_headers()


    def guess_type(self, path):
        """Guess the type of a file.
        Argument is a PATH (a filename).
        Return value is a string of the form type/subtype,
        usable for a MIME Content-type header.
        The default implementation looks the file's extension
        up in the table self.extensions_map, using application/octet-stream
        as a default; however it would be permissible (if
        slow) to look inside the data to make a better guess.
        """

        base, ext = posixpath.splitext(path)
        if ext in self.extensions_map:
            return self.extensions_map[ext]
        ext = ext.lower()
        if ext in self.extensions_map:
            return self.extensions_map[ext]
        else:
            return self.extensions_map['']


    def repeat_to_length(self, string_to_expand, length):
        #return (string_to_expand * int(math.floor(length/len(string_to_expand))+1))
        return (string_to_expand * int(length))

    def list_directory(self, path):
        """Helper to produce a directory listing (absent index.html).
        Return value is either a file object, or None (indicating an
        error).  In either case, the headers are sent, making the
        interface the same as for send_head().
        """
        try:
            list = os.listdir(path)
        except Exception as e:
            self.send_error(404, "No permission to list directory")
            return None
        list.sort(key=lambda a: a.lower())
        f = StringIO()
        displaypath = cgi.escape(urllib.unquote(self.path))

        tree="";
        x=displaypath.split("/")[1:-1]
        xlen=len(x)
        textp=""
        dot = self.repeat_to_length("../", xlen)
        for e in x:
            textp=textp+e+"/"
            tree=tree+"/"+'<a href="{0}">{1}</a>\n'.format(dot+textp, cgi.escape(e))
        tree ='<a href="{0}">{1}</a>\n'.format(dot, ".") + tree

        if not displaypath.endswith('/'):
            displaypath = displaypath + "/";


        f.write('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">')
        f.write(BODY)
        f.write("<html>\n<title>Directory listing for %s</title>\n" % displaypath)
        f.write("<body>\n<h2>Directory listing for %s</h2>\n" % tree)
        f.write("<hr>\n<ul>\n")
        for name in list:
            fullname = os.path.join(path, name)
            displayname = linkname = name
            # Append / for directories or @ for symbolic links
            if os.path.isdir(fullname):
                displayname = name + "/"
                linkname = fullname[1:] + "/"
            if os.path.islink(fullname):
                displayname = name + "@"
                # Note: a link to a directory displays with @ and links with /
            f.write('<li><a href="%s">%s</a>\n'
                    % (urllib.quote(linkname), cgi.escape(displayname)))
        f.write("</ul>\n<hr>\n</body>\n</html>\n")
        length = f.tell()
        f.seek(0)
        self.send_response(200)
        encoding = sys.getfilesystemencoding()
        self.send_header("Content-type", "text/html; charset=%s" % encoding)
        # self.send_header("Content-Length", str(length))
        self.end_headers()
        return f

    if not mimetypes.inited:
        mimetypes.init() # try to read system mime.types
    extensions_map = mimetypes.types_map.copy()
    extensions_map.update({
        '': 'application/octet-stream', # Default
        '.py': 'text/plain',
        '.c': 'text/plain',
        '.h': 'text/plain',
        })



HTTPServer((SV_HOST, SV_PORT), Handler).serve_forever()
