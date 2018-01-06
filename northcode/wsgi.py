"""
WSGI config for northcode project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.9/howto/deployment/wsgi/
"""

import os,sys

from django.core.wsgi import get_wsgi_application

#os.environ.setdefault("DJANGO_SETTINGS_MODULE", "northcode.settings")
os.environ["DJANGO_SETTINGS_MODULE"] = "northcode.settings"

#sys.path.append('/var/www/northcode.no/')

application = get_wsgi_application()
