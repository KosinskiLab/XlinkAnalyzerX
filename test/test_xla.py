import unittest
import os

import chimerax.xlinkanalyzer

class test_window(unittest.TestCase):
    '''
    example test
    '''
    def setUp(self):
        pass

    def test_gui(self):
    # from chimera import dialogs
    # return dialogs.display(XlinkAnalyzer_Dialog.name)
        self.assertEqual(4, 4)

if __name__ == '__main__':
    unittest.main()