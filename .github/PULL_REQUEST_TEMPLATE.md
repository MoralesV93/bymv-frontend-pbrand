<!-- Title: Provide a concise, descriptive title for the PR -->
# Title

**Summary**
- Brief: Implement Brand landing page and assets for the marketing campaign.
- Branch: feature/APP-BrandPage

**Why**
- Purpose: Provide a dedicated marketing/brand page to showcase brand messaging and assets required for upcoming campaign.
- Context: Completes design handoff ticket and removes the temporary placeholder page.

**What Changed**
- High-level: Adds new Brand page HTML, CSS additions, images, and JavaScript tweaks to support layout and interactions.
- Key files (examples): app/www/index.html, app/www/css/styles.css, app/www/img/*, app/www/js/custom-min.js

**Behavioral / UX Notes**
- Mobile-first layout with responsive breakpoints.
- Accessibility: semantic headings and alt text added for images (note any outstanding a11y items).

**Testing / How to QA**
- Local:
  1. Serve the site (from project root or `app/www`) using your usual dev server.
  2. Navigate to the Brand page URL and verify:
     - Layout matches design across breakpoints.
     - Hero image loads and alt text present.
     - Primary CTA navigates to expected target.
     - No console errors on load or interaction.
- Manual checks: Desktop/tablet/mobile screenshots, keyboard navigation for CTAs, image fallbacks.

**Screenshots / Attachments**
- Attach before/after screenshots or a short GIF demonstrating responsiveness and CTA interaction.

**Checklist**
- [ ] Summary and scope present
- [ ] Linked issue(s) referenced
- [ ] Manual testing steps included
- [ ] Accessibility basics verified (headings, alt text, color contrast)
- [ ] No console errors in dev tools
- [ ] Assets optimized and checked into repo
- [ ] Changelog or release notes updated if required

**Migration / DB / Infra**
- None (frontend-only change).

**Deployment Notes & Rollback**
- Deploy via the usual frontend build pipeline.
- If issues appear, rollback to previous commit and re-deploy the last green build.

**Related Issues / Tickets**
- APP-BrandPage (link issue ID here)

**Reviewers & Labels**
- Suggested reviewers: frontend lead, UX owner, QA engineer.
- Labels: enhancement, frontend, needs-review, ready-for-qa

**Release Notes (short)**
- Adds a new Brand landing page and supporting assets for the marketing campaign.

<!-- Optional: any additional notes for reviewers -->
