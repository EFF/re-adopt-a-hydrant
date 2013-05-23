Mangouste = require 'mangouste'
chai = require 'chai'
assert = chai.assert
sinon = require 'sinon'
mongoose = require 'mongoose'
ObjectId = mongoose.Types.ObjectId

describe 'interactors', () =>
    beforeEach () =>
        @fixtures = require './fixtures'
        @mangouste = new Mangouste @fixtures
        @userInteractor = require '../../server/interactors/user_interactor'
        @adoptionInteractor = require '../../server/interactors/adoption_interactor'
        @hydrantInteractor = require '../../server/interactors/hydrant_interactor'

    afterEach () =>
        @mangouste.restore()

    describe 'UserInteractor', () =>
        it 'should get a user by id', () =>
            expectedOutput = @fixtures.User[0].toObject()
            expectedOutput.adoptions = [
                @fixtures.Adoption[0]
                @fixtures.Adoption[1]
            ]
            id = @fixtures.User[0]._id.toString()
            callback = sinon.spy()
            
            @userInteractor.getById id, callback
            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue callback.calledWith(null, expectedOutput), 'should be called with the right arguments'

    describe 'AdoptionInteractor', () =>
        it 'should getUserAdoptions', () =>
            callback = sinon.spy()
            userId = @fixtures.User[0]._id.toString()

            expectedOutput = [
                @fixtures.Adoption[0]
                @fixtures.Adoption[1]
            ]

            @adoptionInteractor.getUserAdoptions userId, callback
            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue callback.calledWith(null, expectedOutput), 'callback should be called with the right arguments'

        it 'should getAdoptionByHydrantId', () =>
            callback = sinon.spy()
            hydrantId = @fixtures.Adoption[0].hydrantId
            expectedOutput = @fixtures.Adoption[0]

            @adoptionInteractor.getAdoptionByHydrantId hydrantId, callback

            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue callback.calledWith(null, expectedOutput), 'callback should be called with the right arguments'

        it.skip 'should adoptHydrant', () =>
            #TODO fix this test ... There's a problem with mangouste
            callback = sinon.spy()
            userId = new ObjectId()
            hydrantId = 'IZkE04heQhalDjpo9R6tdv'
            @adoptionInteractor.adoptHydrant userId, hydrantId, callback

            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue callback.calledWith(null), 'callback should be called with the right arguments'

    describe 'HydrantInteractor', () =>

        it 'should attach adopter to hydrants', () =>
            callback = sinon.spy()
            input = [
                {_id: 'fQkE04heQhalfjpo9R6tdw'}
                {_id: 'IZkE04heQhalDjpo9R6tdw'} #This one should have an adopter
            ]
            expectedOutput = [
                {_id: 'fQkE04heQhalfjpo9R6tdw', adopter: null}
                {_id: 'IZkE04heQhalDjpo9R6tdw', adopter: @fixtures.User[0]._id}
            ]
            @hydrantInteractor._attachAdoptionToHydrants input, callback
            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue callback.calledWith(null, expectedOutput), 'callback should be called with the right arguments'

        it 'should handle search callback', () =>
            callback = sinon.spy()
            fakeData =
                metadata: {}
                data:[
                    {_id: 'fQkE04heQhalfjpo9R6tdw'}
                    {_id: 'IZkE04heQhalDjpo9R6tdw'}
                ]
            sinon.stub @hydrantInteractor, '_attachAdoptionToHydrants', (hydrants, callback) =>
                callback null, hydrants
            @hydrantInteractor._handleSearchCallback callback, null, fakeData

            assert.isTrue callback.calledOnce
            assert.isTrue callback.calledWith(null, fakeData.data)

            @hydrantInteractor._attachAdoptionToHydrants.restore()
            

        it 'should create a query to get the nearest hydrants sorted by distance in a radius of 3km', () =>
            lat = 46.884106
            lon = 71.377042
            distance = '3km'
            expectedOutput = 
                sort: [
                    _geo_distance:
                        location:
                            lat: lat
                            lon: lon
                ]
                query:
                    filtered:
                        query:
                            match_all: {}
                        filter:
                            geo_distance:
                                distance: distance
                                location:
                                    lat: lat
                                    lon: lon

            actualOutput = @hydrantInteractor._createQuery lat, lon
            assert.deepEqual actualOutput, expectedOutput
