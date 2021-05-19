
<!--#echo json="package.json" key="name" underline="=" -->
rc210117_pmb
============
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
A MineTest CSM that tries to help wire 3rd-party applications to a MineTest
client.
<!--/#echo -->



Project status
--------------

2021-05-18, MineTest v5.4.0: No useful results so far.

* All my attempts to set up useful inter-process communication with the
  existing official MineTest client have failed.
* I was not able of convince MineTest core developers to devote their time
  and effort to helping with better IPC.
* It seems that MineTest core developers merely accept the idea of CSMs
  but don't like it very much.




How you can help
----------------

MineTest issues that might get us closer to nice IPC:

* [10823](https://github.com/minetest/minetest/issues/10823)
  Allow to configure file descriptors for interacting with CSMs.

This list is probably incomplete.
If you find other auspicious issues or PRs, please suggest them.




Known issues
------------

* Needs more/better tests and docs.




&nbsp;


License
-------
<!--#echo json="package.json" key=".license" -->
ISC
<!--/#echo -->
