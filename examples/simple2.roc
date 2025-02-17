app [main] {
    cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.8.1/x8URkvfyi9I0QhmVG98roKBUs_AZRkLFwFJVJ3942YA.tar.br",
    json: "../package/main.roc", # use release URL (ends in tar.br) for local example, see github.com/lukewilliamboswell/roc-json/releases
}

import cli.Stdout
import cli.Task
import json.Core
import "data.json" as requestBody : List U8

main =
    decoder = Core.jsonWithOptions {}

    decoded : Decode.DecodeResult (List DataRequest)
    decoded = Decode.fromBytesPartial requestBody decoder

    when decoded.result is
        Ok list ->
            Stdout.line! "Successfully decoded list"

            when List.get list 0 is
                Ok rec -> Stdout.line! "Name of first person is: $(rec.lastname)"
                Err _ -> Stdout.line! "Error occurred in List.get"

        Err TooShort -> Stdout.line! "A TooShort error occurred"

DataRequest : {
    id : I64,
    firstname : Str,
    lastname : Str,
    email : Str,
    gender : Str,
    ipaddress : Str,
}

# =>
# Successfully decoded list
# Name of first person is: Penddreth
