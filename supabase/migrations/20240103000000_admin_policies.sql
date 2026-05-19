-- Allow authenticated users to manage flashcards
create policy "authenticated users can insert flashcards" on public.flashcards
  for insert with check (auth.role() = 'authenticated');

create policy "authenticated users can delete flashcards" on public.flashcards
  for delete using (auth.role() = 'authenticated');

-- Allow authenticated users to manage categories
create policy "authenticated users can insert categories" on public.categories
  for insert with check (auth.role() = 'authenticated');

create policy "authenticated users can delete categories" on public.categories
  for delete using (auth.role() = 'authenticated');
