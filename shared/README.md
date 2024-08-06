# Command-line interface

1.  Run the `install` sub-command in a terminal:

        at-driver install

    If prompted for system administration permission, grant permission.

2.  Start the server by executing the `serve` sub-command in a terminal:

        at-driver serve

    The process will write a message to the standard error stream when the
    WebSocket server is listening for connections. The `--help` flag will cause
    the command to output advanced usage instructions (e.g. `at-driver --help`).

3.  Configure any screen reader to use the synthesizer named "Microsoft Speech
    API version 5" and the text-to-speech voice named "Bocoup Automation Voice."

4.  Use any WebSocket client to connect to the server. The protocol is described
    below. (The server will print protocol messages to its standard error stream
    for diagnostic purposes only. Neither the format nor the availability of
    this output is guaranteed, making it inappropriate for external use.)
