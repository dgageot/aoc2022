package main

import (
	"fmt"
	"math/big"
	"sort"
)

type Monkey struct {
	items     []*big.Int
	op        func(*big.Int) *big.Int
	divisor   *big.Int
	ifTrue    int
	ifFalse   int
	inspected int
	b         *big.Int
}

func (m *Monkey) Clear() {
	m.items = nil
}

func (m *Monkey) Tally() {
	m.inspected += len(m.items)
}

func (m *Monkey) Target(item *big.Int) int {
	if m.b == nil {
		m.b = new(big.Int)
	}
	if m.b.Mod(item, m.divisor).BitLen() == 0 {
		return m.ifTrue
	}
	return m.ifFalse
}

func (m *Monkey) Receive(item *big.Int) {
	m.items = append(m.items, item)
}

func main() {
	// b0 := big.NewInt(0)
	// b2 := big.NewInt(2)
	b19 := big.NewInt(19)
	b6 := big.NewInt(6)
	b3 := big.NewInt(3)

	monkeys := []*Monkey{
		{
			items:   []*big.Int{big.NewInt(79), big.NewInt(98)},
			op:      func(old *big.Int) *big.Int { return old.Mul(old, b19) },
			divisor: big.NewInt(23),
			ifTrue:  2,
			ifFalse: 3,
		},
		{
			items:   []*big.Int{big.NewInt(54), big.NewInt(65), big.NewInt(75), big.NewInt(74)},
			op:      func(old *big.Int) *big.Int { return old.Add(old, b6) },
			divisor: big.NewInt(19),
			ifTrue:  2,
			ifFalse: 0,
		},
		{
			items: []*big.Int{big.NewInt(79), big.NewInt(60), big.NewInt(97)},
			op:    func(old *big.Int) *big.Int { return old.Mul(old, old) },
			// op:      func(old *big.Int) *big.Int { return old.Exp(old, b2, b0) },
			divisor: big.NewInt(13),
			ifTrue:  1,
			ifFalse: 3,
		},
		{
			items:   []*big.Int{big.NewInt(74)},
			op:      func(old *big.Int) *big.Int { return old.Add(old, b3) },
			divisor: big.NewInt(17),
			ifTrue:  0,
			ifFalse: 1,
		},
	}

	for i := 0; i < 20; i++ {
		for _, monkey := range monkeys {
			monkey.Tally()
			for _, item := range monkey.items {
				worry := monkey.op(item)
				worry = worry.Div(worry, b3)
				monkeys[monkey.Target(worry)].Receive(worry)

			}
			monkey.Clear()
		}
	}

	sort.Slice(monkeys, func(i, j int) bool { return monkeys[i].inspected > monkeys[j].inspected })
	fmt.Println(monkeys[0].inspected * monkeys[1].inspected)
}
