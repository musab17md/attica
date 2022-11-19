# Generated by Django 4.1.2 on 2022-11-16 05:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_noti_product_name'),
    ]

    operations = [
        migrations.CreateModel(
            name='Group',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('group_name', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'group',
                'managed': True,
            },
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('type', models.CharField(max_length=50)),
                ('username', models.CharField(max_length=50)),
                ('password', models.CharField(max_length=50)),
                ('branch', models.CharField(max_length=50)),
                ('agent', models.CharField(max_length=50)),
                ('date', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'user',
                'managed': True,
            },
        ),
    ]