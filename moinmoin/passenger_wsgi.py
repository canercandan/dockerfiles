# -*- coding: iso-8859-1 -*-
import sys, os
INTERP = "/usr/bin/python2.7"
if sys.executable != INTERP: os.execl(INTERP, INTERP, *sys.argv)
sys.path.insert(0, '/usr/lib/python2.7/site-packages')
sys.path.insert(0, '/usr/local/share/moin')
from MoinMoin.web.serving import make_application
application = make_application(shared=True)
