import functions_framework

@functions_framework.http
def hello_http(request):
    """Responds with 'Hello <name>!'"""
    data = request.get_json(silent=True) or {}
    name = data.get("name") or request.args.get("name", "World")
    return f"Hello {name}!"

"""
Test with:
https://function-url.run.app/?name=Victor
"""