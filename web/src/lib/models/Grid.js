import Cell from '@/lib/models/Cell.js';
import SolutionValidator from '@/lib/SolutionValidator.js';

export default class Grid {
  constructor(gridSize, cells) {
    this.gridSize = gridSize;
    this.cells = cells;
  }

  static generateRandomGrid(gridSize) {
    const cellCount = gridSize * gridSize;
    const cells = Array.from({ length: cellCount }, (_, index) => {
      const value = parseInt(Math.floor(Math.random() * (gridSize + 1)));
      return new Cell(index, value, gridSize, value > 0);
    });
    return new Grid(gridSize, cells);
  }

  static fromGridString(gridString = '') {
    const gridValues = gridString.split('');
    const gridSize = Math.sqrt(gridValues.length);

    if (gridSize === Math.floor(gridSize) && gridSize > 0) {
      const cells = Array.from({ length: gridValues.length }, (_, index) => {
        const value = gridValues[index];
        const intValue = parseInt(value);
        return new Cell(index, intValue, gridSize, intValue > 0);
      });

      return new Grid(gridSize, cells);
    }

    return null;
  }

  get rows() {
    return [...Array(this.gridSize)].map((_, index) => {
      const startIndex = index * this.gridSize;
      return this.cells.slice(startIndex, startIndex + this.gridSize);
    });
  }

  get cols() {
    return [...Array(this.gridSize)].map((_, index) => {
      return this.cells.filter((cell) => (cell.index % this.gridSize) === index);
    });
  }

  get blocks() {
    return [...Array(this.gridSize)].map((_, index) => {
      const blockCount = Math.sqrt(this.gridSize);
      const blockColIndex = index % blockCount;
      const blockRowIndex = Math.floor(index / blockCount);
      const startIndex = blockRowIndex * (this.gridSize * blockCount);

      const threeRows = this.cells.slice(startIndex, startIndex + (this.gridSize * blockCount));

      return threeRows.filter((cell) => {
        const moduloStart = blockColIndex * blockCount;
        const moduloEnd = moduloStart + blockCount;
        const modulo = cell.index % this.gridSize;

        return modulo >= moduloStart && modulo < moduloEnd;
      });
    });
  }

  get hasEmptyCells() {
    return this.cells.some((cell) => cell.value === 0);
  }

  cellAt(index) {
    return this.cells[index];
  }

  isValid() {
    if (this.hasEmptyCells) {
      return false;
    } else {
      return new SolutionValidator(this).isSolutionValid();
    }
  }

  toQueryString() {
    return this.cells.map((cell) => `${cell.value}`).join('');
  }
}
