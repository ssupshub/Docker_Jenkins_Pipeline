const request = require('supertest');
const app = require('../app');
const chai = require('chai');
const should = chai.should();

describe('Homepage', function() {
  it('should display the homepage at / GET', function(done) {
    request(app)
      .get('/')
      .expect(200)
      .end(function(err, res) {
        if (err) return done(err);
        done();
      });
  });

  it('should contain the word Sparta at / GET', function(done) {
    request(app)
      .get('/')
      .expect(200)
      .end(function(err, res) {
        if (err) return done(err);
        res.text.should.contain('Sparta');
        done();
      });
  });
});

describe('Fibonacci', function() {
  it('should display the correct fibonacci value at /fibonacci/10 GET', function(done) {
    request(app)
      .get('/fibonacci/10')
      .expect(200)
      .end(function(err, res) {
        if (err) return done(err);
        res.text.should.contain('55');
        done();
      });
  });
});
