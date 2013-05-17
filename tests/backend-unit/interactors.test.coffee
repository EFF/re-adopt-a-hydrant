chai = require 'chai'
assert = chai.assert
sinon = require 'sinon'
mongoose = require 'mongoose'
ObjectId = mongoose.Types.ObjectId

describe 'interactors', () ->
    beforeEach () ->
        @objectId = new ObjectId()
        @objectIdAsString = @objectId.toString()
        @fakeDocument = 
            _id: @objectId
        
        @fakeModel = sinon.spy()
        @fakeModel.findById = sinon.stub().yields(null, @fakeDocument)
        @fakeModel.find = sinon.stub().yields(null, [@fakeDocument])
        @fakeModel.findOne = sinon.stub().yields(null, @fakeDocument)
        @fakeModel.prototype.save = sinon.stub().yields(null, @fakeDocument)

        sinon.stub mongoose, 'model', () =>
            return @fakeModel

    afterEach () ->
            mongoose.model.restore()

    describe 'UserInteractor', () ->
        beforeEach () ->
            @userInteractor = require '../../server/interactors/user_interactor'
            @adoptionInteractor = require '../../server/interactors/adoption_interactor'

            @fakeAdoptions = [{userId: @objectIdAsString, hydrantId: @objectIdAsString}]
            sinon.stub @adoptionInteractor, 'getUserAdoptions', (id, callback) ->
                callback null, @fakeAdoptions

        afterEach () ->
            @adoptionInteractor.getUserAdoptions.restore()

        it 'should get a user by id', () ->
            callback = sinon.spy()
            @userInteractor.getById @objectIdAsString, callback

            expectedOutput = @fakeDocument
            expectedOutput.adoptions = @fakeAdoptions
            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue @fakeModel.findById.calledOnce, 'findById should be called'
            assert.isTrue @fakeModel.findById.calledWith(@objectIdAsString, 'id username displayName name pictureUrl', callback), 'findById should be called with the right arguments'
            assert.isTrue callback.calledWith(null, expectedOutput)

    describe 'AdoptionInteractor', () ->
        beforeEach () ->
            @adoptionInteractor = require '../../server/interactors/adoption_interactor'

        it 'should getUserAdoptions', () ->
            callback = sinon.spy()
            @adoptionInteractor.getUserAdoptions @objectIdAsString, callback

            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue @fakeModel.find.calledOnce, 'find should be called'
            assert.isTrue @fakeModel.find.calledWith({userId: @objectId}, callback), 'find should be called with the right arguments'

        it 'should getAdoptionByHydrantId', () ->
            callback = sinon.spy()
            @adoptionInteractor.getAdoptionByHydrantId @objectIdAsString, callback

            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue @fakeModel.findOne.calledOnce, 'findOne should be called'
            assert.isTrue @fakeModel.findOne.calledWith({hydrantId: @objectIdAsString}, callback), 'findOne should be called with the right arguments'

        it 'should adoptHydrant', () ->
            callback = sinon.spy()
            @adoptionInteractor.adoptHydrant @objectIdAsString, @objectIdAsString, callback

            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue @fakeModel.calledOnce, 'constructor should be called'
            assert.equal @fakeModel.prototype.save.firstCall.thisValue.userId, @objectIdAsString, 'adoption.userId should be set'
            assert.equal @fakeModel.prototype.save.firstCall.thisValue.hydrantId, @objectIdAsString, 'adoption.hydrantId should be set'
            assert.isTrue @fakeModel.prototype.save.calledOnce, 'should be called once'
            assert.isTrue @fakeModel.prototype.save.calledWith(callback), 'save should be called with the right arguments'

    describe 'HydrantInteractor', () ->
        beforeEach () ->
            @adoptionInteractor = require '../../server/interactors/adoption_interactor'
            @hydrantIdWithAnAdoption = (new ObjectId()).toString()
            sinon.stub @adoptionInteractor, 'getAdoptionByHydrantId', (hydrantId, callback) =>
                if hydrantId == @hydrantIdWithAnAdoption
                    callback null, {userId: @objectIdAsString}
                else
                    callback()

            @hydrantInteractor = require '../../server/interactors/hydrant_interactor'

        afterEach () ->
            @adoptionInteractor.getAdoptionByHydrantId.restore()

        it 'should attach adoption to hydrants', () ->
            callback = sinon.spy()
            input = [
                {_id: @objectIdAsString}
                {_id: @objectIdAsString}
                {_id: @hydrantIdWithAnAdoption}
                {_id: @objectIdAsString}
            ]
            expectedOutput = [
                {_id: @objectIdAsString, adopter: null}
                {_id: @objectIdAsString, adopter: null}
                {_id: @hydrantIdWithAnAdoption, adopter: @objectIdAsString}
                {_id: @objectIdAsString, adopter: null}
            ]
            @hydrantInteractor._attachAdoptionToHydrants input, callback
            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue callback.calledWith(null, expectedOutput), 'callback should be called with the right arguments'

        it 'should handle search callback', () ->
            callback = sinon.spy()
            fakeData =
                metadata: {}
                data:[
                    {_id: @objectIdAsString}
                    {_id: @objectIdAsString}
                    {_id: @objectIdAsString}
                    {_id: @objectIdAsString}
                ]
            sinon.stub @hydrantInteractor, '_attachAdoptionToHydrants', (hydrants, callback) ->
                callback null, hydrants

            @hydrantInteractor._handleSearchCallback callback, null, fakeData

            assert.isTrue callback.calledOnce
            assert.isTrue callback.calledWith(null, fakeData.data)

            @hydrantInteractor._attachAdoptionToHydrants.restore()
            

        it 'should create a query to get the nearest hydrants sorted by distance in a radius of 3km', () ->
            lat = 46.884106
            lon = 71.377042
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
                                distance: '3km'
                                location:
                                    lat: lat
                                    lon: lon

            actualOutput = @hydrantInteractor._createQuery lat, lon
            assert.deepEqual actualOutput, expectedOutput
