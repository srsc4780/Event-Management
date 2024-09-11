const request = require('supertest');
const app = require('../../src/app');

describe('Event API Integration Tests', () => {
    let eventId;

    it('should create a new event', async () => {
        const res = await request(app)
            .post('/api/events')
            .send({
                title: 'Conference',
                description: 'Tech Conference 2024',
                date: '2024-09-25T12:00:00Z',
                location: 'Virtual',
                organizer: 'Tech Group',
                eventType: 'Conference'
            });
        
        expect(res.statusCode).toEqual(201);
        expect(res.body.success).toBe(true);
        expect(res.body.data).toHaveProperty('id');
        eventId = res.body.data.id;
    });

    // Add more integration tests for other routes (getAllEvents, getEventById, etc.)
});
