chai = require 'chai'
assert = chai.assert
sinon = require 'sinon'
mongoose = require 'mongoose'
ModelLoader = require '../server/model_loader'
Mangouste = require '../lib/mangouste'
ObjectId = mongoose.Types.ObjectId
path = require 'path'

describe 'mangouste', () =>
    describe 'contructor', () =>
        it 'should create a Mangouste instance with empty fixtures', () =>
            mangouste = new Mangouste()
            assert.ok mangouste
            assert.instanceOf mangouste, Mangouste
            assert.isObject mangouste.fixtures
            assert.deepEqual mangouste.fixtures, {}
            mangouste.restore()

        it 'should create a Mangouste instance with fixtures', () =>
            fixtures = 
                ModelName: [
                    {_id: new ObjectId()}
                    {_id: new ObjectId()}
                    {_id: new ObjectId()}
                ]
            mangouste = new Mangouste fixtures
            assert.ok mangouste
            assert.instanceOf mangouste, Mangouste
            assert.isObject mangouste.fixtures
            assert.deepEqual mangouste.fixtures, fixtures
            mangouste.restore()

    describe 'queries', () =>
        before () ->
            SampleModel = mongoose.model 'SampleModel',
                name: String
                number: Number

        beforeEach () =>
            SampleModel = mongoose.model 'SampleModel'
            @fixtures = {}
            @fixtures.SampleModel = []

            @fixtures.SampleModel.push new SampleModel({name: 'Jack', number: 5})
            @fixtures.SampleModel.push new SampleModel({name: 'Frank', number: 11})
            @fixtures.SampleModel.push new SampleModel({name: 'Tone', number: 5})

            @mangouste = new Mangouste @fixtures
        
        afterEach () =>
            @mangouste.restore()

        describe 'findById', () =>
            it 'should find an element in the fixtures by id', (done) =>
                SampleModel = mongoose.model 'SampleModel'

                SampleModel.findById @fixtures.SampleModel[1]._id, (err, result) =>
                    assert.isNull err
                    assert.ok result
                    assert.isObject result
                    assert.deepEqual result, @fixtures.SampleModel[1]
                    done()

            it 'should return null if the element is not found', (done) =>
                SampleModel = mongoose.model 'SampleModel'
                SampleModel.findById new ObjectId(), (err, result) =>
                    assert.isNull err
                    assert.isNull result
                    done()

        describe 'findOne', () =>
            it 'should find one element from the fixtures matching 1 property', (done) =>
                conditions = 
                    name: 'Jack'
                SampleModel = mongoose.model 'SampleModel'
                SampleModel.findOne conditions, (err, result) =>
                    assert.isNull err
                    assert.ok result
                    assert.isObject result
                    assert.deepEqual result, @fixtures.SampleModel[0]
                    done()

            it 'should find one element from the fixtures matching 2 properties', (done) =>
                conditions = 
                    name: 'Jack'
                    number: 5
                SampleModel = mongoose.model 'SampleModel'
                SampleModel.findOne conditions, (err, result) =>
                    assert.isNull err
                    assert.ok result
                    assert.isObject result
                    assert.deepEqual result, @fixtures.SampleModel[0]
                    done()

            it 'should return null if one property does not match', (done) =>
                conditions = 
                    name: 'Jack'
                    number: 11
                SampleModel = mongoose.model 'SampleModel'
                SampleModel.findOne conditions, (err, result) =>
                    assert.isNull err
                    assert.isNull result
                    done()

        describe 'find', () =>
            it 'should return all matching elements from the fixtures', (done) =>
                conditions = 
                    number: 5
                SampleModel = mongoose.model 'SampleModel'
                SampleModel.find conditions, (err, results) =>
                    assert.isNull err
                    assert.ok results
                    assert.isArray results
                    assert.include results, @fixtures.SampleModel[0]
                    assert.include results, @fixtures.SampleModel[2]
                    assert.notInclude results, @fixtures.SampleModel[1]
                    done()

        describe 'save', () =>
            it 'should save the new item in the fixtures and call the callback without error and with a copy of the document', (done) =>
                SampleModel = mongoose.model 'SampleModel'
                sampleModel = new SampleModel
                    name: 'Bob'
                    number: 42
                sampleModel.save (err, result) =>
                    assert.isNull err
                    assert.ok result
                    assert.isObject result
                    assert.propertyVal result, 'name', 'Bob'
                    assert.propertyVal result, 'number', 42
                    assert.property result, '_id'
                    assert.include @mangouste.fixtures.SampleModel, result
                    done()
