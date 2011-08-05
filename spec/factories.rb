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

