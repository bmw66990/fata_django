# Generated by Django 3.0.5 on 2020-09-25 08:39

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('valve', '0002_auto_20200925_1634'),
    ]

    operations = [
        migrations.RenameField(
            model_name='voltage',
            old_name='valtage',
            new_name='voltage',
        ),
    ]
