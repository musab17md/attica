# Generated by Django 4.1.2 on 2022-11-19 04:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0006_pics2_photographer_id'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Pics',
        ),
        migrations.AddField(
            model_name='pics2',
            name='vendor_id',
            field=models.CharField(default=0, max_length=50),
            preserve_default=False,
        ),
    ]
