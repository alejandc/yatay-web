user1 = User.create(:username => "alejandc", :email => 'alejandro.claveir@gmail.com', :password => "admin1234", :password_confirmation => "admin1234")
user1.add_role :admin

user2 = User.create(:username => "lara", :email => 'monti.lara.i@gmail.com', :password => "admin1234", :password_confirmation => "admin1234")
user2.add_role :admin

30.times do
  Certificate.create!(titular:             "Pedro Lopez",
                      document_type:       "DNI",
                      document_number:     "123245343",
                      address:             "Av. Velez Sarfield 1234",
                      taxi_license_number: "#{rand(0..99999)}",
                      car_brand:           "Chevrolet",
                      clock_brand:         "FUL-MAR",
                      car_model:           2013,
                      domain_number:       "MUO 095",
                      clock_number:        "C#{rand(111111..999999)}",
                      precinct_number:     "000#{rand(1111..9999)}",
                      motor_number:        "JSDJ8726387126",
                      chasis_number:       "KJ3H42KLJ43243KJH",
                      observations:        "Sin observaciones",
                      pulses_per_km:       rand(1..10))
end      