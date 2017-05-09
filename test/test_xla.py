import unittest
import os
import sys
# for k in sys.modules.keys():
#     print(k)
import chimerax.xlinkanalyzer

class test_xla(unittest.TestCase):
    '''
    example test
    '''
    def setUp(self):
        pass

    def test_gui(self):
        self.assertEqual(4, 4)
        print(dir(session.ui))
        print(session.ui.main_window)


print(__name__)
sys.modules['__main__'].test_xla = test_xla
# if __name__ == '__main__':
if __name__ == 'ChimeraX_sandbox_1':
    unittest.main()