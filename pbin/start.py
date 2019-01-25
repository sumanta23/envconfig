#!/usr/bin/env python


#install pip & libtmux
import libtmux
import yaml
import sys
import os
import argparse


def createwindow(session, name, repo_path):
    print("creatig window " + name)
    windows = session.windows
    tempwindow = None
    for window in windows:
        if window.name == name:
            tempwindow = window
    if tempwindow is None:
        print(repo_path)
        tempwindow = session.new_window(attach=False, window_name=name, start_directory=repo_path)
    return tempwindow

def currentRunningWindows(session):
    windows = session.windows
    temp = []
    for window in windows:
        temp.append(window)
    return temp

def getWindowByName(session, name, repo_path):
    windows = session.windows
    temp = None
    for window in windows:
        if window.name == name:
            temp = window
    if temp is not None:
        killwindow(session, name)
    temp = createwindow(session, name, repo_path)
    return temp

def currentRunningServers(window):
    panes = window.list_panes()
    temp = []
    for pane in panes:
        for item in pane.items():
            if item[0] == 'pane_current_command':
                temp.append(item[1])
    return temp

def killSession(session):
    session.kill_session()

def killwindow(session, windowname):
    try:
        session.kill_window(windowname)
    except:
        print("")

def runCommand(pane, command):
     pane.send_keys(command, enter=False, suppress_history=False)
     pane.enter()

def createPane(window, repo_path):
    pane = window.split_window(start_directory=repo_path)
    pane.select_pane()
    return pane

def createPaneAndRunCommand(window, command, repo_path):
    pane = createPane(window, repo_path)
    runCommand(pane, command)


def main(sessionObj, action, doc, args):
    windows = doc["windows"]
    repo_path = doc["repo_path"]
    for window in windows:
        if window['window_name'] in args:
            winObj = getWindowByName(sessionObj, window['window_name'], repo_path)
            if action == "stop":
                killwindow(sessionObj, window['window_name'])
                return
            panes = window['panes']
            cpane = winObj.list_panes()
            runCommand(cpane[0], panes.pop())
            for command in panes:
                createPaneAndRunCommand(winObj, command, repo_path)
            winObj.select_layout(window['layout'])
    killwindow(sessionObj, 'bash')

def createServer(session_name):
    server = libtmux.Server()
    session = None
    if session_name is None:
        session_name = "server"

    try:
        session = server.find_where({ "session_name": session_name })
    except:
        print("Unexpected error:", sys.exc_info()[0])

    if session is None:
        session = server.new_session(session_name)
    return session


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='starts bot servers.')
    parser.add_argument('action', help='start or stop etc')
    parser.add_argument('server', type=str, nargs='+', help='app admin', default='app admin')
    list_servers = parser.parse_args().server
    action = parser.parse_args().action
    print(list_servers)
    print(action)

    script_dir = os.path.dirname(__file__)
    rel_path = "server.yaml"

    cwd = os.getcwd()
    cur_file_path = os.path.join(cwd, rel_path)
    if os.path.isfile(cur_file_path):
        script_dir=cwd

    abs_file_path = os.path.join(script_dir, rel_path)

    with open(abs_file_path, 'r') as f:
        doc = yaml.load(f)

    if list_servers is None:
        list_servers = ['app', 'admin']
    sessionObj = createServer(doc["session_name"])
    main(sessionObj, action, doc, list_servers)
