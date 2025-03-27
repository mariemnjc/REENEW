require 'date'
require "open-uri"

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
# photo_salon = [
#   file1 = URI.parse("https://tinyurl.com/3r5jz87n").open.rewind,
#   file2 = URI.parse("https://cdn1.treatwell.net/images/view/v2.i2462971.w720.h480.xA241127B/").open.rewind,
#   file3 = URI.parse("https://images.squarespace-cdn.com/content/v1/5c7e7f2d840b16a251e308d3/1616762707383-0ZLKS1MQEYN92BG9TRPI/Institut+Menasa+Bridaine.png?format=750w").open.rewind,
#   file4 = URI.parse("https://www.parisselectbook.com/wp-content/uploads/2021/07/SB-19451new-scaled-1-scaled.jpg").open.rewind,
#   file5 = URI.parse("https://www.leslouves.com/wp-content/uploads/2017/05/1_free-persephone-paris.jpg").open.rewind,
#   file6 = URI.parse("https://uploads.lebonbon.fr/source/2024/auriane/maison-koton-institut-paris.jpeg").open.rewind,
#   file7 = URI.parse("https://cdn1.treatwell.net/images/view/v2.i3080085.w1080.h720.xABFDFFF9/").open.rewind
# ]

salons = [
  {name: "Maison de Beauté Dulcenae", address: "60 Rue de Caumartin, 75009 Paris", description: "Ici, les soins prennent acte de la singularité des corps,", phone: "0142001230", opening_hour: "9h00 - 18h00", certified: true, user_id: admin.id},
  {name: "Mon Petit Institut", address: "78 Rue Marguerite de Rochechouart, 75009 Paris", description: "Votre bien-être est entre de bonnes mains !", phone: "0142001231", opening_hour: "9h00 - 18h00", certified: true, user_id: admin.id},
  {name: "Salon de Beauté La Perle", address: "23 Bd du Montparnasse, 75006 Paris", description: "La perle des salons de beauté !", phone: "0142001232", opening_hour: "9h00 - 18h00", certified: true, user_id: admin.id},
  {name: "Institut de Beauté L'Orchidée", address: "10 rue Rémusat, 31000 Toulouse", description: "On s'occupe de tout, vous s'occupez de rien", phone: "0142001231", opening_hour: "9h00 - 18h00", certified: true, user_id: admin.id},
  {name: "BeautyMiss", address: "5 rue de Metz, 31000 Toulouse", description: "Il ya Miss France et il y a BeautyMiss", phone: "0142001232", opening_hour: "9h00 - 18h00", certified: true, user_id: admin.id},
  {name: "Beau'Thé", address: "6 place Saint-Sernin, 31000 Toulouse", description: "Thé à la menthe et Manucures, quoi de mieux?", phone: "0142001231", opening_hour: "9h00 - 18h00", certified: true, user_id: admin.id},
  {name: "Bio Institut", address: "20 Alsace-Lorraine, 31000 Toulouse", description: "Le bio au service de la beauté", phone: "0142001232", opening_hour: "9h00 - 18h00", certified: true, user_id: admin.id},
]
created_salons = salons.map do |s|
  salon=Salon.create(
    name: s[:name],
    address: s[:address],
    description: s[:description],
    phone: s[:phone],
    opening_hour: s[:opening_hour],
    certified: s[:certified],
    user_id: admin.id

  )
  puts "#{salon.name}"
  
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
  {first_name: "Marie", last_name: "Dupont", trainings: "CAP Esthétique, BTS Esthétique", experiences: "5 ans d'expérience", salon_id: Salon.first.id},
  {first_name: "Sophie", last_name: "Martin", trainings: "CAP Esthétique, BTS Esthétique", experiences: "3 ans d'expérience", salon_id: Salon.first.id},
  {first_name: "Julien", last_name: "Lefevre", trainings: "CAP Esthétique, BTS Esthétique", experiences: "7 ans d'expérience", salon_id: Salon.first.id}
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
    salon: Salon.first
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
