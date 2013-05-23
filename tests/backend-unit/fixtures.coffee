path = require 'path'
ModelLoader = require '../../server/model_loader'
mongoose = require 'mongoose'
ObjectId = mongoose.Types.ObjectId
ModelLoader.loadSync path.join(__dirname, '../../server/models')

User = mongoose.model 'User'
Adoption = mongoose.model 'Adoption'

fixtures = {}
fixtures.Adoption = []
fixtures.User = []

user1 = new User()
user1.provider = 'facebook'
user1.id = '678752472'
user1.displayName = 'Jacques-Olivier D. Bernier'
user1.username = 'jacquesolivier.d.bernier'
user1.gender = 'male'
user1.accessToken = 'CAACp16tePyQBAC2mXK6d64738oBznQGRgetSZCK1Qi05m2K8DnO2mJlxMZAN8wXfqbrS0lPlnEy8UjHGH3IdeZBDodiQd64mc8JunZB7NC8dmNwlUGAyHoTHo61ZAZBgNgrjzPiEUOkAYerD7s3weS'
user1.pictureUrl = 'http://graph.facebook.com/678752472/picture'
fixtures.User.push user1

user2 = new User()
user2.provider = 'facebook'
user2.id = '100001798921934'
user2.displayName = 'François-Xavier Poulin Darveau'
user2.username = 'francoisxavier.poulindarveau'
user2.gender = 'male'
user2.accessToken = 'CAACp16tePyQBAGwhfvE7xqdDjSOQZBuWL2CkIr4VUrEfQ22XTGbfYxup8DPV6hZCv9kPqcLy0YqewcdZAW7VZBvA5vEFmJLbjpOy0jVqwxZBu9FCa9p6cFVS4m2o6uc1vEZAU9Dq2ZBZCJCwZBDFzdjpu6WQTlAYFMgQUE'
user2.pictureUrl = 'http://graph.facebook.com/100001798921934/picture'
fixtures.User.push user2

adoption1 = new Adoption()
adoption1.hydrantId = 'IZkE04heQhalDjpo9R6tdw'
adoption1.userId = user1._id
fixtures.Adoption.push adoption1

adoption2 = new Adoption()
adoption2.hydrantId = 'rS4urO6PSRSYhg_tuRKL4Q'
adoption2.userId = user1._id

fixtures.Adoption.push adoption2

module.exports = fixtures
