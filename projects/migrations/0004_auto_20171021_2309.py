# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2017-10-21 21:09
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('projects', '0003_auto_20160121_2057'),
    ]

    operations = [
        migrations.AlterField(
            model_name='project',
            name='text',
            field=models.TextField(),
        ),
    ]
