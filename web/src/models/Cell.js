export default class Cell {
  constructor(index, value, gridSize, locked) {
    this.index = index;
    this.value = value;
    this.gridSize = gridSize;
    this.locked = locked;
    this.pencilMarks = new Set();
  }

  get row() {
    return Math.floor(this.index / this.gridSize);
  }

  get col() {
    return Math.floor(this.index % this.gridSize);
  }

  get orderedPencilMarks() {
    return Array.from(this.pencilMarks).sort();
  }

  clearCell() {
    if (this.value > 0) {
      this.value = 0;
    } else {
      this.pencilMarks.clear();
    }
  }

  togglePencilMark(value) {
    if (!this.locked) {
      if (this.pencilMarks.has(value)) {
        this.pencilMarks.delete(value);
      } else {
        this.pencilMarks.add(value);
      }
    }
  }
}
