Book.destroy_all

Book.create!([{
  title: "Hyperion",
  description: "Probably my favorite science fiction book (and series) I've \n
  ever read. Hyperion is written in a style similar to The Canterbury Tales, \n
  in which a series of stories are told by the main characters. Each story is \n
  a gem in itself, but alude to the larger storyline. The scope of the story \n
  is ambitious - spanning time, planets religion and love.",
  price: 5.99,
  stock: 20,
},
{
  title: "Jony Ive: The Genius Behind Apple's Greatest Products",
  description: "Even though I respect Ive, I felt this biography only hit \n
  skin deep. It went over all the major events in his life, his passion for \n
  design, awards he achieved -- but that's really it. I dont't feel I know \n
  him anymore than before reading this.",
  price: 6.50,
  stock: 12,
},
{
  title: "Mindstorms",
  description: "Although this book focuses on the cognitive advantages to \n
  having children use technology from an early age, it is also an in depth \n
  look at how people can learn for themseves. As someone who was often \n
  distracted and bored at times during school, Mindstorms highlights some of \n
  the reasoning behind that feeling and what we can do as teachers to help \n
  minimize it.",
  price: 7,
  stock: 17,
}])

puts "Created #{Book.count} books."
