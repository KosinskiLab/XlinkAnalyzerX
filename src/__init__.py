# vim: set expandtab shiftwidth=4 softtabstop=4:

from chimerax.core.toolshed import BundleAPI


class _MyAPI(BundleAPI):

    @staticmethod
    def start_tool(session, tool_name):
        # 'start_tool' is called to start an instance of the tool
        # If providing more than one tool in package,
        # look at 'tool_name' to see which is being started.

        from .tool import ToolUI
        # UI should register itself with tool state manager
        return ToolUI(session, tool_name)

    @staticmethod
    def register_command(command_name, logger):
        # We expect that there is a function in "cmd"
        # corresponding to every registered command
        # in "setup.py.in" and that they are named
        # identically (except with '_' replacing spaces)
        from . import cmd
        from chimerax.core.commands import register
        base_name = command_name.replace(" ", "_")
        func = getattr(cmd, base_name)
        desc = getattr(cmd, base_name + "_desc")
        register(command_name, desc, func)


bundle_api = _MyAPI()
