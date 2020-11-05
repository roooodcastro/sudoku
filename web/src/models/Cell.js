export default class Cell {
  constructor(index, value, gridSize, locked) {
    this.index = index;
    this.value = value;
    this.gridSize = gridSize;
    this.locked = locked;
  }

  get row() {
    return Math.floor(this.index / this.gridSize);
  }

  get col() {
    return Math.floor(this.index % this.gridSize);
  }
}
