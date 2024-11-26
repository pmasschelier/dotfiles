@register
class CustomTmuxSetup(GenericCommand):
    """Setup a comfortable tmux debugging environment."""
    _cmdline_ = "custom-tmux-setup"
    _syntax_  = f"{_cmdline_}"
    # optionally
    # _examples_ = [f"{_cmdline_} arg1 ...", ]
    # _aliases_ = ["alias_to_cmdline", ]

    def do_invoke(self, argv):
        self.dont_repeat()

        tmux = os.getenv("TMUX")
        if not tmux:
            return
        tmux = which("tmux")
        ok("tmux session found, splitting window...")

        pane, pty = subprocess.check_output([tmux, "splitw", "-h", '-F#{session_name}:#{window_index}.#{pane_index}-#{pane_tty}', "-P"]).decode().strip().split("-")
        atexit.register(lambda : subprocess.run([tmux, "kill-pane", "-t", pane]))
        # clear the screen and let it wait for input forever
        gdb.execute(f"!'{tmux}' send-keys -t {pane} 'clear ; cat' C-m")
        gdb.execute(f"!'{tmux}' select-pane -L")

        ok(f"Setting `context.redirect` to '{pty}'...")
        gdb.execute(f"gef config context.redirect {pty}")
        ok("Done!")

        # Put the new pane into copy-mode
        # gdb.execute(f"!'{tmux}' set-hook pane-focus-in \"copy-mode -t {pane}\"")
        # gdb.execute(f"!'{tmux}' set-hook -t 0 pane-focus-in \"send-keys -t {pane} q\"")

        return


