# Generated by Django 4.1.2 on 2022-10-29 09:41

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_alter_account_ornament_type_alter_account_purity'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='account',
            name='purity',
        ),
    ]
