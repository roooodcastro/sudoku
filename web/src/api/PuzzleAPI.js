import ApiBase from '@/api/ApiBase.js';
import Routes from '@/api_routes.js';

class PuzzleAPI {
  getPuzzle(puzzleId) {
    return ApiBase
      .get(Routes.puzzle_url(puzzleId))
      .catch((error) => Promise.reject(error.response.data.error))
      .then((response) => response.data.puzzle);
  }
}

export default new PuzzleAPI();
