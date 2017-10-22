from django.db import models

# Create your models here.
class PingEntry(models.Model):
    servername = models.CharField(max_length=50)
    ipaddress = models.CharField(max_length=20)
    uptime = models.CharField(max_length=100)

    def __str__(self):
        return "srv: " + self.servername + ", ip: " + self.ipaddress + ", uptime: " + self.uptime
