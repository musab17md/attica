from email.policy import default
from django.db import models

# Create your models here.


metal_choice = [
        ('Gold','Gold'),
        ('Silver','Silver'),
    ]

ornaments = ["tikkas", "earrings", "anklets", "bangles", "rings", "necklaces", "pendants", "toe rings", "bracelets", "nose pins"]
ornament_choice = []
for orn in ornaments:
    ornament_choice.append((orn, orn))


class Account(models.Model):
    select_metal = models.CharField(max_length=15,default='Select',choices=metal_choice)
    ornament_type = models.CharField(max_length=15,default='Select',choices=ornament_choice)
    purity = models.DecimalField(max_digits = 5, decimal_places = 2)

    def __str__(self):
        return str(self.select_metal)
        