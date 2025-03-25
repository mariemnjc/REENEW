require 'date'

puts "Nettoyage DB..."
Booking.destroy_all
ProfessionalService.destroy_all
Service.destroy_all
Diploma.destroy_all
Professional.destroy_all
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

puts "Création des professionnels pour le premier salon..."
professionals = [
  {first_name: "Marie", last_name: "Dupont", trainings: "CAP Esthétique, BTS Esthétique", experiences: "5 ans d'expérience", salon_id: salons.first.id},
  {first_name: "Sophie", last_name: "Martin", trainings: "CAP Esthétique, BTS Esthétique", experiences: "3 ans d'expérience", salon_id: salons.first.id},
  {first_name: "Julie", last_name: "Lefevre", trainings: "CAP Esthétique, BTS Esthétique", experiences: "7 ans d'expérience", salon_id: salons.first.id}
]

puts " Création des diplômes pour le premier professionnel..."
diplomas = [
  { title: "CAP Esthétique", date: "2015" },
  { title: "BTS Esthétique", date: "2017" },
  { title: "Certificat de maquillage", date: "2019" }
]

puts "Création des professionnels et de leurs diplômes..."
created_professionals = []

professionals.each do |p|
  professional = Professional.create!(p)
  created_professionals << professional

  diplomas.each do |d|
    Diploma.create!(d.merge(professional: professional))
  end
end

puts 'Création des services pour le premier salon...'
created_services = services_data.map do |s|
  Service.create!(
    name: s[:name],
    category: s[:category],
    price: s[:price],
    salon: salons.first
  )
end

puts "Création des liens entre pro et services..."
created_professionals.each do |pro|
  created_services.sample(2).each do |service|
    ProfessionalService.create!(
      professional: pro,
      service: service
    )
  end
end

# puts "Création de réservations..."
# bookings.each do |b|
#   Booking.create!(
#     rating: b[:rating],
#     review: b[:review],
#     user: admin,
#     professional_service: ProfessionalService.all.sample,
#     start_date: Date[:start_date],
#     end_date: b[:end_date]
#   )
# end
# t.integer "rating"
# t.text "review"
# t.bigint "user_id", null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.bigint "professional_service_id"
# t.datetime "start_date"
# t.datetime "end_date"
# t.index ["professional_service_id"], name: "index_bookings_on_professional_service_id"
# t.index ["user_id"], name: "index_bookings_on_user_id"


puts "Seed des services et salons terminée avec succès."
