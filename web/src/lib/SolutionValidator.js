export default class SolutionValidator {
  constructor(grid) {
    this.grid = grid;
  }

  isSolutionValid() {
    const rowsValid = this.grid.rows.every((row) => this.hasDuplicate(row));
    const columnsValid = this.grid.cols.every((col) => this.hasDuplicate(col));
    const blocksValid = this.grid.rows.every((block) => this.hasDuplicate(block));

    return rowsValid && columnsValid && blocksValid;
  }

  hasDuplicate(cells) {
    const values = cells.map((cell) => cell.value);
    return new Set(values).size === values.length;
  }
}
