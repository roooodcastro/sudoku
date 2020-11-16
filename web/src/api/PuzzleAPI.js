import api from 'axios';
import Routes from '@/api_routes.js';

class PuzzleAPI {
  getPuzzle(puzzleId) {
    return api.get(Routes.puzzles_url(puzzleId));
  }
}

export default new PuzzleAPI();
