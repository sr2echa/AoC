use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

fn main() -> io::Result<()> {
    let path = Path::new("input.txt");
    let input = File::open(&path)?;
    let buffered = io::BufReader::new(input);

    let lines: Vec<String> = buffered.lines().filter_map(Result::ok).collect();

    println!("Part 1: {}", solve(&lines));

    let modified_lines: Vec<String> = lines.iter().map(|line| replace_(&line.to_lowercase())).collect();
    println!("Part 2: {}", solve(&modified_lines));

    Ok(())
}

fn solve(lines: &[String]) -> u32 {
    lines.iter().filter_map(|line| {
        let digits: Vec<_> = line.chars().filter(|c| c.is_digit(10)).collect();
        match (digits.first(), digits.last()) {
            (Some(&first), Some(&last)) => Some(first.to_digit(10).unwrap() * 10 + last.to_digit(10).unwrap()),
            _ => None,
        }
    }).sum()
}

fn replace_(line: &str) -> String {
    line.replace("nine","n9e")
        .replace("eight","e8t")
        .replace("seven","s7n")
        .replace("six","s6x")
        .replace("five","f5e")
        .replace("four","f4r")
        .replace("three","t3e")
        .replace("two","t2o")
        .replace("one","o1e")
}

