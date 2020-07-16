export interface IWork {
    title: string;
    description: string;
    isDone: boolean;
    goalTime: string;
    id: number;
    personId: number;
    ownerId: number;
  }

export class Work {
    title: string;
    description: string;
    isDone: boolean;
    goalTime: string;
    id: number;
    personId: number;
    ownerId: number;
}
