package main

import "fmt"

type Blueprint struct {
	OreOre        int64
	ClayOre       int64
	ObsidianOre   int64
	ObsidianClay  int64
	GeodeOre      int64
	GeodeObsidian int64
}

type Game struct {
	Blueprint Blueprint
	Cache     map[int64]int64
}

const MAX = 32

func (g *Game) recurse(turn, ore, clay, obsidian, geode, r_ore, r_clay, r_obsidian, r_geode int64) int64 {
	if turn == MAX+1 {
		return r_geode
	}

	key := r_geode<<0 |
		r_obsidian<<8 |
		r_clay<<16 |
		r_ore<<24 |
		geode<<32 |
		obsidian<<38 |
		clay<<44 |
		ore<<50 |
		turn<<56

	cached, present := g.Cache[key]
	if present {
		return cached
	}

	if turn <= (MAX - 1) {
		// Always the best choice
		if r_obsidian >= g.Blueprint.GeodeObsidian && r_ore >= g.Blueprint.GeodeOre {
			return g.recurse(
				turn+1,
				ore, clay, obsidian, geode+1,
				r_ore+ore-g.Blueprint.GeodeOre, r_clay+clay, r_obsidian+obsidian-g.Blueprint.GeodeObsidian, r_geode+geode,
			)
		}
	}

	max := g.recurse(
		turn+1,
		ore, clay, obsidian, geode,
		r_ore+ore, r_clay+clay, r_obsidian+obsidian, r_geode+geode,
	)

	if turn <= (MAX - 2) {
		if r_clay >= g.Blueprint.ObsidianClay && r_ore >= g.Blueprint.ObsidianOre {
			other := g.recurse(
				turn+1,
				ore, clay, obsidian+1, geode,
				r_ore+ore-g.Blueprint.ObsidianOre, r_clay+clay-g.Blueprint.ObsidianClay, r_obsidian+obsidian, r_geode+geode,
			)
			if other > max {
				max = other
			}
		}
	}
	if turn <= (MAX - 3) {
		if r_ore >= g.Blueprint.ClayOre {
			other := g.recurse(
				turn+1,
				ore, clay+1, obsidian, geode,
				r_ore+ore-g.Blueprint.ClayOre, r_clay+clay, r_obsidian+obsidian, r_geode+geode,
			)
			if other > max {
				max = other
			}
		}
	}
	if turn <= (MAX - 4) {
		if r_ore >= g.Blueprint.OreOre {
			other := g.recurse(
				turn+1,
				ore+1, clay, obsidian, geode,
				r_ore+ore-g.Blueprint.OreOre, r_clay+clay, r_obsidian+obsidian, r_geode+geode,
			)
			if other > max {
				max = other
			}
		}
	}

	g.Cache[key] = max
	return max
}

func (g *Game) play() int64 {
	return g.recurse(1, 1, 0, 0, 0, 0, 0, 0, 0)
}

func main() {
	// total := 1
	// for _, blueprint := range []Blueprint{
	// 	{4, 2, 3, 14, 2, 7},
	// } {
	// 	game := &Game{blueprint, map[int64]int64{}}
	// 	geode := game.play()
	// 	fmt.Println(geode)
	// 	total *= int(geode)
	// }
	// fmt.Println("Step 2 - Sample", total)

	total := 1
	for _, blueprint := range []Blueprint{
		{4, 4, 2, 11, 4, 8},
		{4, 4, 2, 16, 4, 16},
		{3, 4, 4, 18, 2, 11},
	} {
		game := &Game{blueprint, map[int64]int64{}}
		geode := game.play()
		fmt.Println(geode)
		total *= int(geode)
	}
	fmt.Println("Step 2 - Input", total)
}
