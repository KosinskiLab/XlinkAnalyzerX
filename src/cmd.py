# vim: set expandtab ts=4 sw=4:

from chimerax.core.commands import CmdDesc, AtomicStructuresArg
from chimerax.core.atomic import AtomicStructure


def xla_show(session, structures=None):
    session.logger.info("Displaying crosslinks")

xla_show_desc = CmdDesc(optional=[("structures", AtomicStructuresArg)])


# def subcommand_function(session, positional_arguments, keyword_arguments):
#     pass
# subcommand_desc = CmdDesc()

# TODO: Add more subcommands here