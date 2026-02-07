import express, { Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Mock Data
const mockTransactions = [
  { id: '1', title: 'Netflix', category: 'Lazer', amount: -55.90, date: new Date() },
  { id: '2', title: 'Salário App', category: 'Renda', amount: 8500.00, date: new Date() },
  { id: '3', title: 'Uber', category: 'Transporte', amount: -24.50, date: new Date() },
];

const mockAccounts = [
  { id: 'acc_1', bank: 'Nubank', balance: 5450.80 },
  { id: 'acc_2', bank: 'Itaú', balance: 7000.00 },
];

// Routes
app.get('/api/health', (req: Request, res: Response) => {
  res.json({ status: 'UP', timestamp: new Date() });
});

app.get('/api/finance/consolidated', (req: Request, res: Response) => {
  const total = mockAccounts.reduce((acc, curr) => acc + curr.balance, 0);
  res.json({
    totalBalance: total,
    accounts: mockAccounts,
    currency: 'BRL'
  });
});

app.get('/api/finance/transactions', (req: Request, res: Response) => {
  res.json(mockTransactions);
});

// Open Finance Webhook Mock
app.post('/api/open-finance/webhook', (req: Request, res: Response) => {
  console.log('Received Open Finance Webhook:', req.body);
  res.status(202).send();
});

app.listen(PORT, () => {
  console.log(`Backend Senior Financeivo rodando na porta ${PORT}`);
});
