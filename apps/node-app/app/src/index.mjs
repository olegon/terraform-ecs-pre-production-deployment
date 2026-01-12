import express from 'express';
import config from './package.json' with { type: "json" };

const PORT = ('PORT' in process.env)
    ? parseInt(process.env.PORT, 10)
    : 5000;
const ENVIRONMENT = process.env.ENVIRONMENT
    ?? 'unknown';

const router = express.Router();
router.get('/', (_, res) => res.send(`Hello from ${ENVIRONMENT}! ;)`));
router.get('/v1/health', (_, res) => res.send('Healthy!'));
router.get('/v1/version', (_, res) => res.send(config.version));

const app = express();
app.use('/', router);

app.listen(PORT, () => console.log(`Listening on port ${PORT}.`));
