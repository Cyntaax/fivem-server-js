import { Module } from "citadel";

export default class EXPManager {
	currentXP = 0;
	ranks = [
		800, 2100, 3800, 6100, 9500, 12500, 16000, 19800, 24000, 28500, 33400, 38700, 44200, 50200, 56400, 63000, 69900,
		77100, 84700, 92500, 100700, 109200, 118000, 127100, 136500, 146200, 156200, 166500, 177100, 188000, 199200,
		210700, 222400, 234500, 246800, 259400, 272300, 285500, 299000, 312700, 326800, 341000, 355600, 370500, 385600,
		401000, 416600, 432600, 448800, 465200, 482000, 499000, 516300, 533800, 551600, 569600, 588000, 606500, 625400,
		644500, 663800, 683400, 703300, 723400, 743800, 764500, 785400, 806500, 827900, 849600, 871500, 893600, 916000,
		938700, 961600, 984700, 1008100, 1031800, 1055700, 1079800, 1104200, 1128800, 1153700, 1178800, 1204200, 1229800,
		1255600, 1281700, 1308100, 1334600, 1361400, 1388500, 1415800, 1443300, 1471100, 1499100, 1527300, 1555800,
		1584350
	];

	maxRank = 7999;

	public addXP(xp: number) {
		if (xp < 0) {
			return;
		}

		let currentLevel = this.getLevelFromXP(this.currentXP);
		let currentXPWithAdded = this.currentXP + xp;
		let newLevel = this.getLevelFromXP(currentXPWithAdded);
		let levelDifference = 0;

		if (newLevel > this.maxRank - 1) {
			newLevel = this.maxRank - 1;
			currentXPWithAdded = this.getXPCeilingForLevel(this.maxRank - 1);
		}

		if (newLevel > currentLevel) {
			levelDifference = newLevel - currentLevel;
		}

		if (levelDifference > 0) {
			let startAtLevel = currentLevel;

			// create rank bar

			for (let i = 0; i < levelDifference; i++) {
				startAtLevel += 1;
				if (i === levelDifference) {
					// create rank bar 1
				} else {
					// create rank bar 2
				}
			}
		} else {
			// create rank bar 3;
		}

		this.currentXP = currentXPWithAdded;

		if (levelDifference > 0) {
		}
	}

	public removeXP(xp: number) {
		if (xp < 0) {
			return;
		}

		let currentLevel = this.getLevelFromXP(this.currentXP);
		let currentXPWithRemovedXP = this.currentXP - xp;
		let newLevel = this.getLevelFromXP(currentXPWithRemovedXP);
		let levelDifference = 0;

		if (newLevel < 1) {
			newLevel = 1;
		}

		if (currentXPWithRemovedXP < 0) {
			currentXPWithRemovedXP = 0;
		}

		if (newLevel < currentLevel) {
			levelDifference = Math.abs(newLevel - currentLevel);
		}

		if (levelDifference > 0) {
			let startLevel = currentLevel;
			for (let i = 0; i < levelDifference; i++) {
				startLevel--;
				if (i === levelDifference) {
					// animate 1
				} else {
					// animate 2
				}
			}
		} else {
			// normal rank bar
		}

		this.currentXP = currentXPWithRemovedXP;
	}

	public getXPFloorForLevel(level: number) {
		if (level > 7999) {
			level = 7999;
		}

		if (level < 2) {
			return 0;
		}

		if (level > 100) {
			let baseXP = this.ranks[99];
			let extraAddPerLevel = 50;
			let minAddPerLevel = 28550;
			let baseLevel = level - 100;
			let currXPNeeded = 0;
			for (let i = 0; i < baseLevel; i++) {
				minAddPerLevel += 50;
				currXPNeeded += minAddPerLevel;
			}

			return baseXP + currXPNeeded;
		}
		return this.ranks[level - 1];
	}

	public getXPCeilingForLevel(level: number) {
		if (level > 7999) {
			level = 7999;
		}
		if (level < 1) {
			return 800;
		}

		if (level > 99) {
			let baseXP = this.ranks[99];
			let extraPerLevel = 50;
			let minAddPerLevel = 28550;
			let baseLevel = level - 99;
			let currXPNeeded = 0;
			for (let i = 0; i < baseLevel; i++) {
				minAddPerLevel += 50;
				currXPNeeded += minAddPerLevel;
			}
			return baseXP + currXPNeeded;
		}
		return this.ranks[level];
	}

	public getLevelFromXP(xpAmount: number) {
		const search = xpAmount;

		if (search < 0) {
			return 1;
		}

		if (search < this.ranks[99]) {
			let currLevelFound = -1;
			let currLevelScan = 0;
			for (const xp of this.ranks) {
				currLevelScan++;
				if (search < xp) {
					break;
				}
			}
			return currLevelScan;
		} else {
			let currLevelFound = -1;
			const baseXP = this.ranks[99];
			let extraPerLevel = 50;
			let minAddPerLevel = 28550;

			let currXPNeeded = 0;
			for (let i = 0; i < this.maxRank - 99; i++) {
				minAddPerLevel += 50;
				currXPNeeded += minAddPerLevel;
				currLevelFound = i;
				if (search < baseXP + currXPNeeded) {
					break;
				}
			}
			return currLevelFound + 99;
		}
	}
}
