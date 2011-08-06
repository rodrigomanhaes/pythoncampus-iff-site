Factory.define :presentation do |p|
  p.title 'Aux Armes Citoyens!'
  p.association :speaker
end

Factory.define :speaker do |s|
  s.name 'Robespierre Danton'
end

Factory.define :short_course, :parent => :presentation do |m|
  m.kind 'Minicurso'
end

Factory.define :attendee do |a|
  a.sequence(:name) {|n| "Attendee #{n}" }
  a.sequence(:email) {|n| "attendee#{n}@mail.com" }
end

Factory.define :registration do |r|
  r.association :attendee
  r.association :presentation, :factory => :short_course
end

Factory.define :confirmed_registration, :parent => :registration do |c|
  c.confirmed_at { Time.now }
end

Factory.define :user do |u|
  u.sequence(:email) {|n| "admin#{n}@mail.com" }
  u.password 'topsecret'
  u.password_confirmation 'topsecret'
end

