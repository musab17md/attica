# Generated by Django 4.1.2 on 2022-10-29 09:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_account_purity'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='purity',
            field=models.DecimalField(decimal_places=2, max_digits=5),
        ),
    ]