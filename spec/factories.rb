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
  r.association :presentation
end

