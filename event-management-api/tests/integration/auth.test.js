const request = require('supertest');
const app = require('../../src/app');

describe('Auth API Integration Tests', () => {
    it('should register a new user', async () => {
        const res = await request(app)
            .post('/api/auth/register')
            .send({
                name: 'John Doe',
                email: 'john@example.com',
                password: 'password123'
            });
        
        expect(res.statusCode).toEqual(201);
        expect(res.body.success).toBe(true);
        expect(res.body.data).toHaveProperty('id');
    });

    it('should login an existing user', async () => {
        const res = await request(app)
            .post('/api/auth/login')
            .send({
                email: 'john@example.com',
                password: 'password123'
            });
        
        expect(res.statusCode).toEqual(200);
        expect(res.body.success).toBe(true);
        expect(res.body).toHaveProperty('token');
    });
});
