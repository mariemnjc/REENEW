require 'date'

puts "Nettoyage DB..."
Booking.destroy_all
ProfessionalService.destroy_all
Service.destroy_all
Professional.destroy_all
Diploma.destroy_all
Salon.destroy_all
User.destroy_all

puts "Création d'un utilisateur admin..."
admin = User.create!(
  id: 1,
  first_name: "Valentin",
  last_name: "Malemanche",
  email: "vmalemanche@gmail.com",
  phone: "0600000000",
  address: "1 rue du Bien-Être, Paris",
  categories: "esthétique",
  password: "password"
)

puts "Création de salons..."
salons = []
3.times do |i|
  salons << Salon.create!(
    name: "Institut Beauté #{i + 1}",
    address: "#{i + 10} rue Belle, Paris",
    description: "Salon de beauté #{i + 1} avec prestations haut de gamme",
    phone: "01420012#{30 + i}",
    opening_hour: "9h00 - 18h00",
    certified: true,
    user_id: admin.id
  )
end

puts "Création de services pour le premier salon..."
services_data = [
  { name: "Épilation sourcils", category: "Épilation", price: 15 },
  { name: "Épilation jambes complètes", category: "Épilation", price: 30 },
  { name: "Épilation maillot intégral", category: "Épilation", price: 28 },

  { name: "Massage relaxant", category: "Bien-être", price: 60 },
  { name: "Massage tonique", category: "Bien-être", price: 65 },
  { name: "Massage aux pierres chaudes", category: "Bien-être", price: 80 },

  { name: "Soin du visage", category: "Soins", price: 45 },
  { name: "Soin anti-âge", category: "Soins", price: 55 },
  { name: "Soin purifiant", category: "Soins", price: 50 },

  { name: "Manucure express", category: "Manucure", price: 25 },
  { name: "Manucure complète", category: "Manucure", price: 35 },
  { name: "Pose de vernis semi-permanent", category: "Manucure", price: 30 },

  { name: "Pédicure spa", category: "Pédicure", price: 35 },
  { name: "Beauté des pieds", category: "Pédicure", price: 40 },
  { name: "Pose de vernis pieds", category: "Pédicure", price: 20 },

  { name: "Rehaussement de cils", category: "Cils", price: 50 },
  { name: "Teinture de cils", category: "Cils", price: 30 },
  { name: "Pose d'extensions de cils", category: "Cils", price: 70 },

  { name: "Maquillage soirée", category: "Maquillage", price: 55 },
  { name: "Maquillage mariée", category: "Maquillage", price: 90 },
  { name: "Cours d'auto-maquillage", category: "Maquillage", price: 65 }
]

services_data.each do |s|
  Service.create!(
    name: s[:name],
    category: s[:category],
    price: s[:price],
    salon: salons.first
  )
end

puts "Seed des services et salons terminée avec succès."
